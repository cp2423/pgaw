DOMAIN=postgres.crwpitcher.com
EMAIL=cp2423@gmail.com

# postgres user is 999 in debian based docker image
# and must be made owner of the ssl certificates
PG_UID=999

# location of ssl ertificates on host
LE_PATH="/etc/letsencrypt/live/$DOMAIN"

# get ssl certificates
INITFILE=init/compose.yaml

docker compose -f "$INITFILE" up -d
docker compose -f "$INITFILE" run --rm certbot certonly \
  -n --agree-tos --webroot --webroot-path /var/www/certbot/ \
  -d "$DOMAIN" \
  -m "$EMAIL"
docker compose -f "$INITFILE" down

# make certificates less permissive else postgres gets upset
for f in `sudo sh -c "ls $LE_PATH/*.pem"`
do
  echo "lowering permissions on $f"
  sudo sh -c "chmod og-rwx $f"
  sudo sh -c "chown $PG_UID:$PG_UID $f"
done

# run main services
docker compose up -d

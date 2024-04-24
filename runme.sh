DOMAIN=postgres.crwpitcher.com

# get ssl certificates
INITFILE=init/compose.yaml
#docker compose -f $INITFILE up -d
#docker compose -f $INITFILE run --rm certbot certonly \
#  -n --agree-tos --webroot --webroot-path /var/www/certbot/ \
#  -d $DOMAIN \
#  -m "cp2423@gmail.com" \
#  --dry-run
#docker compose -f $INITFILE down

# make certificates less permissive else postgres gets upset
LE_PATH="/etc/letsencrypt/live/$DOMAIN"
for f in `sudo sh -c "ls $LE_PATH/*.pem"`
do
  echo "lowering permissions on $f"
  sudo sh -c "chmod og-rwx $f"
  sudo sh -c "chown 999:999 $f"
done

# run main services
docker compose up -d

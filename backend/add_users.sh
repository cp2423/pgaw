PASSWORD="data@GBS"
while read line
do
  /venv/bin/python setup.py add-user "$line" "$PASSWORD"
  echo "Added user $line"
done < "${1:-/dev/stdin}"

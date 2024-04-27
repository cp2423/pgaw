# this code made more sense when pgdb-user was required too

from os import path

SECRETS = ["pgdb-pass"] 

def get_secret(secret):
  secret_path = path.join("/run", "secrets", secret)
  if path.isfile(secret_path):
    with open(secret_path) as f:
      return f.read()

d = {s: get_secret(s) for s in SECRETS}

CONFIG_DATABASE_URI = f"postgresql://postgres:{d['pgdb-pass']}@pg-db:5432/pgadmin"

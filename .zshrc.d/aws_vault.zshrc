YUBIKEY_PROFILE="aws"

awsunset() {
  unset AWS_SESSION_TOKEN
  unset AWS_VAULT
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECURITY_TOKEN
}


_aws_vault_export() {
   aws-vault exec $1 -t $(awstoken) -- env | grep ^AWS | sed -e 's/^/export\ /'
}

aws_auth() {
  awsunset
  eval "$(_aws_vault_export $1)"
}

awstoken() {
  awsunset
  ykman oath code --single "${YUBIKEY_PROFILE}"
}

YUBIKEY_PROFILE="aws"

_aws_unset() {
  unset AWS_SESSION_TOKEN
  unset AWS_VAULT
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECURITY_TOKEN
}


_aws_vault_export() {
   aws-vault exec $1 --no-session -m $(ykman oath code --single "$YUBIKEY_PROFILE" | awk '{print $NF}') -- env | grep ^AWS | sed -e 's/^/export\ /'
}


aws_auth(){
  _aws_unset
  eval "$(_aws_vault_export $1)"
}

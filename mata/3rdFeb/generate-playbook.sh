In generate-playbook.sh
Replace this:
  VAR_FILE=${1:-}   with VAR_FILE="${ANSIBLE_VAR_FILE:-}"


run the bundle like this
  ANSIBLE_VAR_FILE=conf/myvars.yaml ./bundle -- --up

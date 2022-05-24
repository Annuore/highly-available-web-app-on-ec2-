# command to create, update or delete
command=$1

# the name of the stack
stackname=$2

# template file
template="$3"
externalprogram "$template" [challenge.yaml]

case $command in
  create)
    aws cloudformation create-stack \
    --stack-name $2 \
    --template-body $3 \
    --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
    ;;

  update)
    aws cloudformation update-stack \
    --stack-name $2 \
    --template-body $3 \
    ;;

  delete)
    aws cloudformation delete-stack \
    --stack-name $2 \
    ;;
  *)
    echo -n "Wrong argument. Run script as follows:"
    echo -n "Wrong argument. ./cfn.sh arg1 arg2"
    echo -n "Where arg1: create-stack | update-stack | delete-stack"
    echo -n "Where arg2: the name of the stack"
    ;;
esac



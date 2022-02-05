

AWS_HOST=localhost

echo "register sns_id"

curl -XGET -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/user/sns_register -d '{"sns_id":"Uxxxxxxxxxxx_user_id_1_xxxxxxxxxx", "sns_type":1}'


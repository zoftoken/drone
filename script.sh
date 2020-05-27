if [ -z "$PLUGIN_INSTANCE" ];
then echo "Defaulting to ZaaS instance."; PLUGIN_INSTANCE=https://zaas.zoftoken.com/token;
fi

if [ -z "$PLUGIN_ID" -o -z "$PLUGIN_SERVICE" -o -z "$PLUGIN_AUTHKEY" ];
then echo "Missing token parameters - please check the documentation."; exit 1;
fi

TOKENSTATUS=`curl -s "$PLUGIN_INSTANCE/status?id=$PLUGIN_ID&service=$PLUGIN_SERVICE&authKey=$PLUGIN_AUTHKEY"`

if [ "$TOKENSTATUS" == '{"status":1}' ];
then echo "Token is open - allowing operation."; exit 0;
else echo "Token is closed or parameters are invalid - aborting operation."; exit 1;
fi
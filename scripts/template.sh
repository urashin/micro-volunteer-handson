
AWS_HOST=localhost

# local 1st
HANDICAP_TOKEN=(please set your token)
VOLUNTEER_TOKEN=(please set your token)

SCRIPT=step2_checkin.sh


# 浅草寺（雷門）
Y_GEO=35.7107654
X_GEO=139.795978
cat << EOF > ${SCRIPT}

echo "ボランティアの方が位置情報を登録@浅草寺（雷門）"
# API : matching/checkin
# 説明：ボランティアの方が位置情報を登録
# <parameter>
# x_geometry : 経度
# y_geometry : 緯度
curl -XPOST -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/matching/checkin -d '{"token":"${VOLUNTEER_TOKEN}","x_geometry":"${X_GEO}","y_geometry":"${Y_GEO}"}'
echo " "

EOF


Y_GEO=35.7107784
X_GEO=139.7962571
cat << EOF >>  ${SCRIPT}

echo "ボランティアの方が位置情報を登録@雷門通りの横断歩道手前"
# 雷門通りの横断歩道手前
# API : matching/checkin
# 説明：ボランティアの方が位置情報を登録
# <parameter>
# x_geometry : 経度
# y_geometry : 緯度
curl -XPOST -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/matching/checkin -d '{"token":"${VOLUNTEER_TOKEN}","x_geometry":"${X_GEO}","y_geometry":"${Y_GEO}"}'
echo " "

EOF


Y_GEO=35.7106899
X_GEO=139.7966045
cat << EOF >>  ${SCRIPT}

echo "ボランティアのチェックイン@浅草１番出口 checkin"
# API : matching/checkin
# 説明：ボランティアのチェックイン@浅草１番出口 checkin
# <parameter>
# x_geometry : 経度
# y_geometry : 緯度
curl -XPOST -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/matching/checkin -d '{"token":"${VOLUNTEER_TOKEN}","x_geometry":"${X_GEO}","y_geometry":"${Y_GEO}"}'
echo " "

EOF

Y_GEO=35.7367325
X_GEO=139.6512438
cat << EOF >> ${SCRIPT}

echo "ボランティアのチェックイン@ 練馬区役所"
# 
# API : matching/checkin
# 説明 : ボランティアのチェックイン@ 練馬区役所
# <parameter>
# x_geometry : 経度
# y_geometry : 緯度
curl -XPOST -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/matching/checkin -d '{"token":"${VOLUNTEER_TOKEN}","x_geometry":"${X_GEO}","y_geometry":"${Y_GEO}"}'
echo " "

EOF


SCRIPT=step3_help_thanks.sh

Y_GEO=35.7106899
X_GEO=139.7966045
cat << EOF >  ${SCRIPT}

# API : matching/help
# 説明 : 障がい者の方からHelpコール@浅草３番出口
# <parameter>
# x_geometry : 経度
# y_geometry : 緯度
# handicapinfo_id : 2
curl -XPOST -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/matching/help -d '{"token":"${HANDICAP_TOKEN}","x_geometry":"${X_GEO}","y_geometry":"${Y_GEO}","handicapinfo_id":2}'
echo " "

EOF


cat << EOF >>  ${SCRIPT}
# API : matching/accetp
# 説明 : ボランティアがHelpに応じる(matching成立)
# <parameter>
# help_id : Help呼び出し識別ID
curl -XPOST -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/matching/accept -d '{"token":"${VOLUNTEER_TOKEN}","help_id":1}'
echo " "


# API : user/thanks
# 説明 : 障がい者の方からお礼（評価）
# <parameter>
# help_id : Help呼び出し識別ID
# evaluate : 評価
curl -XPOST -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/user/thanks -d '{"token":"${HANDICAP_TOKEN}","help_id":1,"evaluate":10}'
#echo " "


# API : user/history
# 説明 : ボランティア履歴の取得
curl -XGET -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/user/history -d '{"token":"${VOLUNTEER_TOKEN}"}'
EOF

SCRIPT=step1_area_register.sh

Y_GEO=35.7106899
X_GEO=139.7966045
AREA_NAME=浅草３番出口
RADIUS=50
cat << EOF > ${SCRIPT}

# 浅草３番出口 （エリア情報登録）
# API : matching/help
# <parameter>
# x_geometry : 経度
# y_geometry : 緯度
echo "[20]"
curl -XPOST -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/matching/area_register -d '{"token":"${VOLUNTEER_TOKEN}","area_name":"${AREA_NAME}","x_geometry":"${X_GEO}","y_geometry":"${Y_GEO}","radius":${RADIUS}}'
echo " "
EOF


Y_GEO=35.7107784
X_GEO=139.7962571
AREA_NAME=雷門通りの横断歩道手前
RADIUS=50
cat << EOF >>  ${SCRIPT}

echo "ボランティアの方が位置情報を登録@雷門通りの横断歩道手前"
# 浅草３番出口 checkin
# API : matching/help
# 説明 : 障がい者の方からHelpコール
# <parameter>
# x_geometry : 経度
# y_geometry : 緯度
echo "[20]"
curl -XPOST -H "Content-Type: application/json" http://${AWS_HOST}:8080/v1/matching/area_register -d '{"token":"${VOLUNTEER_TOKEN}","area_name":"${AREA_NAME}","x_geometry":"${X_GEO}","y_geometry":"${Y_GEO}","radius":${RADIUS}}'
echo " "
EOF


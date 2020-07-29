echo "========================================================"
dokku maintenance:on medalc
dokku maintenance:on liwi-test
echo "Maintenance enable"
echo "======================================================="
dokku postgres:unlink liwi-test liwi-test
echo "Database unlink"
echo "======================================================="
dokku postgres:destroy liwi-test
echo "Database destroy"
echo "======================================================="
dokku postgres:clone medalc liwi-test
dokku postgres:link liwi-test liwi-test
echo "Clone finish"
echo "======================================================="
dokku run liwi-test rake users:seed_clinicians
echo "Seeds done"
dokku maintenance:off medalc
dokku maintenance:off liwi-test
echo "Maintenance disable"
echo "Finish"

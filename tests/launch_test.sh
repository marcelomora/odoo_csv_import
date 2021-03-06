#Need to launch odoo database accessible with the configuration given in conf/connection.conf
#Modules contacts need to be installed

rm -rf data
mkdir data
export PYTHONPATH=../
echo "> Erase"
python-coverage erase
echo "> Generate data for import"
python-coverage run -a test_import.py
echo "> Run test import"
#sh 0_partner_generated.sh
echo "> Run test split file"
python-coverage run -a test_split.py
echo "> Test mapping from file"
python-coverage run -a test_from_file.py
echo "> Import data with error"
sh 2_contact_import.sh 2> error.log
echo "> Import Product"
python-coverage run -a test_product_v9.py
sh 3_product_import.sh
echo "> Import Product v10"
python-coverage run -a test_product_v10.py
sh 4_product_import.sh
sh 5_partner_export.sh
python-coverage html 

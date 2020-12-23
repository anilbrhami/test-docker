import pytest
from selenium import webdriver
import sys
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
from time import sleep


class Test1:
    def test_iaclogin(self):
         chrome_options = Options()
         chrome_options.add_argument('--disable-extensions')
         chrome_options.add_argument('--headless')
         chrome_options.add_argument('--disable-gpu')
         chrome_options.add_argument('--no-sandbox')
         driver = webdriver.Chrome(options=chrome_options)
         driver.get("https://gui-django-iac-test-validation-staging.americas.abi.dyn.nesc.nokia.net/")
         driver.maximize_window()
         
         driver.find_element_by_name("username").send_keys("admin")
         driver.find_element_by_name("password").send_keys("admin")
         driver.find_element_by_name("login").click()
         sleep(10)
         
         login_user = "admin"
         assert login_user == driver.find_element_by_class_name("user-name").get_attribute('title')

         driver.close()




        

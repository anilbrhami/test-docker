FROM python:3.8-slim

WORKDIR /usr/src/app
COPY test-1.py ./
COPY requirements ./

RUN apt-get update && apt-get install -y \
 wget \
 gnupg2 \
 unzip \
 curl \
 && rm -rf /var/lib/apt/lists/*
 
 # install project requirements
 RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
apt-get -y update && apt-get install -y google-chrome-stable && \
rm -rf /var/lib/apt/lists/*

# install chromedriver
RUN apt-get install -yqq unzip && \
wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip -qq /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ && \
rm /tmp/chromedriver.zip

CMD ["pytest", "-v", "-rA", "--alluredir=.\reports\", "TestCases\test_iAC_uc1.py"]

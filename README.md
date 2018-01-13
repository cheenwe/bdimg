# 下载百度图片接口

1. 新建关键字
2. 关键字检索
3. 图片下载

根据 https://github.com/cheenwe/cheenwe.github.io/blob/master/_posts/sh/baidu_img_download.rb

## 安装

```
# Add PG sources
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdb.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get install -y redis-server \
                        postgresql-9.4 \
                        libpq-dev\
                        ruby2.4 \
                        ruby2.4-dev


sudo service postgresql start
sudo service redis-server start

sudo su postgres -c "createuser -d -R -S $USER"

gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/

sudo gem install bundler
bundle config mirror.https://rubygems.org https://ruby.taobao.org
```

## 使用
```
git clone https://github.com/cheenwe/bdimg.git
cd bdimg
bundle install
rails db:setup
sidekiq -C config/sidekiq.yml
#打开新的终端执行
rails s
```
访问: localhost:3000
新建检索关键字,点击搜索或下载

## 查看处理状态
localhost:3000/sidekiq




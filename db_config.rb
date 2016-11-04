require 'active_record'
#supports other sqls

#tell active records what database to talk to
options = {
  adapter: 'postgresql',
  database: 'sasquatch'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)


# PG.connect({
#  dbname: 'sdfsdf'
# })

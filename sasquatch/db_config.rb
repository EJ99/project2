require 'active_record'
#supports other sqls

#tell active records what database to talk to
options = {
  adapter: 'postgresql',
  database: 'sasquatch'
}

ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  database: 'sasquatch'
})

# PG.connect({
#  dbname: 'sdfsdf'
# })

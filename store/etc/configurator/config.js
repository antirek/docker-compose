(function() {
  module.exports = {
    port: 3000,
    filePath: __dirname + "/uploads",
    sipConf: '/etc/asterisk/sip_viola_configurator.conf',
    mongodb: 'mongodb://localhost/viola',
    ami: {
      port: 5038,
      host: 'localhost',
      username: 'amiadmin',
      password: 123456,
      debug: false
    }
  };

}).call(this);

function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    URL: 'http://localhost:8080/'
  }
  if (env == 'dev') {
    config.URL = 'http://localhost:8080/';
  } else if (env == 'qa') {
    config.URL = 'http://localhost:9090/';
  }
  return config;
}
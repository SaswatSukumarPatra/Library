service = SNService::Service.new
service.signup('Patra')
service.signup('Suk')
service.signup('Saswat')
service.login('Suk')
service.follow('Patra')
service.logout
service.login('Saswat')
service.post('Hello')
service.logout
service.login('Patra')
service.post('Hello2')

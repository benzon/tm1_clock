# tm1_clock
A simple system of counter job time

Requirements :
  - mysql-async
  - es_extended

Instructions :
  - import init.sql to your database
  - put in the config 'tm1_clock'

This system allows you to have an hour meter to count the hours of the players who are on duty.

There are 3 main commands:
- (on_duty) /entrar clock_name
This command is used to enter the service in the specific counter, for example, with the current configuration it would be /entrar policia

- (off_duty) /salir
It is used to take the meter out of service where you are on duty

- (hours) /horas
There are 3 uses for this command, the first is simply to put /horas clock_name, and with this you will get your hours.
The second is to put /horas clock_name source, with this you will get the hours of a specific player who is connected.
The last one is to put /horas clock_name identifier, with this you will get the hours of a specific player who is offline


(clarification)
- clock_name is the name of the clock configured in the config.cfg
- source is the source of the target
- identifier is the identifier of your user db

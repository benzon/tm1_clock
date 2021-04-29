Config = {}

Config.Jobs = {
    ['policis'] = { --Name of the clock
        'polices' --Name of the jobs that can go on duty of that clock
    }
}

Config.JobsRanks = {
    ['policia'] = { --Name of the clock
        {
            name = 'polices', --Name of the job that can get the time of the users
            ranks = {
                'novices' --Ranks of the job that can get the time of the users
            }
        }
    }
}

Config.Commands = {
    on_duty = 'entrars', --Name of the command to go on duty. Usage : /entrar name_of_clock
    off_duty = 'salirs',--Name of the command to go off duty. Usage : /salir
    hours = 'horass' --Get the hours of a clock. /horas name_of_the_clock or for other people  /horas name_of_the_clock user_target or /horas name_of_the_clock identifier
}

--Translations, sorry for the Spanish
Locales = {
    inService = 'Has ~g~entrado ~w~de servicio.',
    youAreInService = 'No ~r~puedes ~w~entrar de servicio, ya que actualmente ya lo estás.',
    youCantInService = 'No ~r~puedes ~w~entrar de servicio, ya que no estás autorizado.',
    jobDontExist = 'Ese trabajo no existe.',
    putAJob = 'Tienes que indicar un trabajo.',
    leftService = 'Has ~g~salido ~w~de servicio.',
    youArentInService = 'No ~r~estás ~w~de servicio.',
    hadBeenInService = ' ha ~g~estado ~w~de servicio : ',
    neverInService = 'Nunca ha estado de servicio en este trabajo el ciudadano : ',
    notAuth = 'No estás autorizado a obtener información de ese trabajo.',
    youHadBeenInService = 'Has ~g~estado ~w~de servicio : ',
    youNeverInService = 'Nunca has estado de servicio en este trabajo.',
    errorArguments = 'Error a la hora de especificar los argumentos.'
}

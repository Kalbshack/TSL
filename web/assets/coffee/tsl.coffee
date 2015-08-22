
tslmodule = angular.module "tslmodule", ["ui.bootstrap"]

tslmodule.controller "tslcontroller", ["$scope", "socket", ($scope, socket) ->
    $scope.num = 0;

    $scope.sendRes = () ->
        socket.emit 'res', 'client Res'
        console.log "send res"
    socket.on 'exe', (data) ->
        $scope.num = data
        console.log data
]



tslmodule.factory 'socket', ['$rootScope', ($rootScope) ->
    socket = io.connect 'http://localhost:3000'
    #socket = io.connect
    console.log "socket created"
 
    return {
        on: (eventName, callback) ->
            socket.on eventName, () ->
                args = arguments
                $rootScope.$apply () ->
                    callback.apply socket, args

        emit: (eventName, data, callback) ->
            socket.emit eventName, data, () ->
                args = arguments
                $rootScope.$apply () ->
                    if callback
                        callback.apply socket, args
    }

]

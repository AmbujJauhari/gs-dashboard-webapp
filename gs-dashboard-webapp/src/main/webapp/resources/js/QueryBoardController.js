angular.module('ui.bootstrap.demo').controller('queryController', function ($scope, $http, $filter,
                                                                            $uibModal, $timeout, $log) {
    $scope.submit = function () {
        var queryForm = {
            "gridName": 'Grid-A',
            "dataType": $scope.selectedDocumentTypeName,
            "criteria": $scope.queryCriteria
        };
        
    };


    $scope.open = function (parameter1) {

        var modalInstance = $uibModal.open({
            templateUrl: 'DetailedQueryView.html',
            controller: ModalInstanceCtrl,
            size: 'lg',
            resolve: {
                detailedObjectProperties: function () {
                    return "loading data..." + parameter1;
                }
            }
        });

        modalInstance.opened.then(function () {
            $scope.loadData(modalInstance);
        }, function () {
            $log.info('Modal dismissed at: ' + new Date());
        });

        $scope.loadData = function (aModalInstance) {
            
            $timeout(function () {
                console.log($scope.selectedDocumentTypeName);
                $scope.detailedTypeName = $scope.selectedDocumentTypeName
                $scope.detailedSpaceId = parameter1
                aModalInstance.setDetailedObjectProperties($scope.selectedDocumentTypeName, parameter1, $scope.spaceIdFieldName);
            }, 3000);
        };

    };

    var ModalInstanceCtrl = function ($scope, $uibModalInstance, detailedObjectProperties) {
        $scope.detailedObjectProperties = detailedObjectProperties;
        var dataTypeDetails;
        var spaceIdName;
        $uibModalInstance.setDetailedObjectProperties = function (dataType, parameter1, spaceIdVarName) {
            spaceIdName = spaceIdVarName;
            dataTypeDetails = dataType;
            $http.get("/query/getDataFromSpaceForTypeForSpaceId.html",
                {params: {"gridName": 'Grid-A', "dataType": dataType, "spaceId": parameter1}})
                .success(function (data) {
                    var editableMap = [];
                    for (var i in data) {
                        editableMap.push(
                            {
                                key: i,
                                value: data[i],
                                disabled: true
                            }
                        )
                    }
                    $scope.detailedObjectProperties = editableMap;
                });
        };

        $scope.edit = function () {
            for (var i in $scope.detailedObjectProperties) {
                $scope.detailedObjectProperties[i].disabled = false;
            }
            $scope.updateEnabled = true;
        };

        $scope.save = function () {
            console.log($scope.detailedObjectProperties);
            var detailedObjectDataForUpdating = {
                gridName: 'Grid-A',
                dataTypeName: dataTypeDetails,
                detailedDataEntry: $scope.detailedObjectProperties,
                spaceIdName: spaceIdName
            };
            $http.post("/query/updateDataInSpaceForTypeForSpaceId", detailedObjectDataForUpdating);
            $scope.updateEnabled = false;
            $uibModalInstance.close('close');
        };

        $scope.cancel = function () {
            $uibModalInstance.dismiss('cancel');
        };
    };
});
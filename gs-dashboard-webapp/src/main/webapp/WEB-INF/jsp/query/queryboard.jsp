<!doctype html>
<html ng-app="ui.bootstrap.demo">
<head>
    <title>Query Board</title>
    <head>
        <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular-animate.js"></script>
        <script src="//angular-ui.github.io/bootstrap/ui-bootstrap-tpls-1.3.3.js"></script>
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://rawgit.com/esvit/ng-table/master/dist/ng-table.min.css">
        <script src="https://rawgit.com/esvit/ng-table/master/dist/ng-table.min.js"></script>

    </head>
    <script type="text/css">
        .app-modal-window .modal-dialog {
            width: 500px;
        }
    </script>
    <script src="../../../resources/js/main.js"></script>
    <script src="../../../resources/js/TypeAheadController.js"></script>
    <script src="../../../resources/js/QueryBoardController.js"/>
</head>

<body>
<script type="text/html">
    <ul class="dropdown-menu" role="listbox">
        <li ng-repeat="match in matches track by $index"/>
    </ul>
</script>

<div class='container-fluid typeahead-demo' ng-controller="documentNameTypeAheadController">
    <h1>Query Board</h1>

    <form class="form-inline" role="form" ng-controller="queryController" ng-submit="submit()">
        <div class="form-group">
            <input type="text" placeholder="type-name" ng-model="selectedDocumentTypeName"
                   uib-typeahead="state for state in states | filter:$viewValue | limitTo:8"
                   class="form-control">
        </div>
        <div class="form-group col-md-offset-1">
            <input type="text" placeholder="search criteria" class="form-control" ng-model="queryCriteria">
        </div>

        <button type="submit" class="btn btn-default col-md-offset-1">Submit</button>
        <div>
            <table ng-table="tableParams" show-filter="true" class="table">
                <thead>
                <tr>
                    <th ng-repeat="headerName in headerNames"
                        class="text-center sortable">
                        {{headerName}}
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr ng-repeat="user in paginatedDetailedDataType">
                    <td ng-repeat="headerName in headerNames">
                        <div class="animate-switch" ng-if="headerName == spaceIdFieldName">
                            <a href="" ng-click="open(user[headerName])"> {{user[headerName]}} </a></div>
                        <div class="animate-switch" ng-if="headerName != spaceIdFieldName">{{user[headerName]}}</div>
                    </td>
                    <script type="text/ng-template" id="DetailedQueryView.html">
                        <div class="modal-header">
                            <h3>Detailed Query view for {{detailedTypeName}} spaceId {{detailedSpaceId}}</h3>
                        </div>
                        <div class="modal-body">
                            <table ng-table="tableParams" show-filter="true" class="table">
                                <thead>
                                <tr>
                                    <th>Key</th>
                                    <th>Value</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr ng-repeat="property in detailedObjectProperties">
                                    <td>{{ property.key }}</td>
                                    <td>
                                        <div ng-show="property.disabled">{{property.value}}</div>
                                        <div ng-hide="property.disabled"><input type="text" ng-model="property.value"/></div>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary" ng-hide="updateEnabled" ng-click="edit()">Edit</button>
                            <button class="btn btn-primary" ng-show="updateEnabled" ng-click="save()">Save</button>
                            <button class="btn btn-warning" ng-click="cancel()">Cancel</button>
                        </div>
                    </script>
                </tr>
                </tbody>
            </table>
        </div>
    </form>
</div>
</body>
</html>
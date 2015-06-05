'use strict';

/**
 * @ngdoc function
 * @name reDevnoteApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the reDevnoteApp
 */
angular.module('reDevnoteApp')
  .controller('AboutCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });

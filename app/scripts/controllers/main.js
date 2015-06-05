'use strict';

/**
 * @ngdoc function
 * @name reDevnoteApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the reDevnoteApp
 */
angular.module('reDevnoteApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });

'use strict';

var dnscheck = angular.module('dnscheck',['ngResource','pascalprecht.translate']);

dnscheck.config(function($translateProvider) {
  $translateProvider.useStaticFilesLoader({
      prefix: '/lang/',
      suffix: '.json'
  });
  $translateProvider.preferredLanguage(navigator.language || navigator.userLanguage);
//  $translateProvider.useLocalStorage();
});

dnscheck.filter("asDate", function () {
      return function (input) {
        if (typeof input ==='undefined') return new Date(); 
        input = input.replace(/\..*$/,"Z");
        input = input.replace(" ","T");
        return new Date(input);
      }
});

dnscheck.directive('lang',function(){

  return {
    restrict: 'E',
    scope: { lang: '@' },
    transclude: true,
    controller: ['$rootScope','$scope','$translate',function($rootScope,$scope, $translate){
      $scope.setLang = function(lang){
        $rootScope.language = lang;
        $translate.use(lang);
      };
    }],
    templateUrl: '/ang/lang'
  };
});

dnscheck.directive('navigation',function(){

  return {
    restrict: 'E',
    transclude: true,
    scope: { navId: '@', inverse: '@' },
    controller: function($scope){
      var panes = $scope.panes = [];
      $scope.select = function(pane) {
        angular.forEach(panes, function(pane) {
          pane.selected = false;
        });
        pane.selected = true;
        $scope.currentTab = pane.tabId;
        $scope.$parent[$scope.navId+'_currentTab'] = pane.tabId;
      };

      this.addPane = function(pane) {
        var c = 0;
        if(typeof t_res !== 'undefined' && typeof t_res.params.nameservers === 'undefined' && $scope.navId=='main'){
          c = 0;
        }
        if(typeof t_res !== 'undefined' && typeof t_res.params.nameservers !== 'undefined' && $scope.navId=='main'){
          c = 1;
        }
        if (panes.length === c) {
          $scope.select(pane);
        }
        panes.push(pane);
      };
    },
    templateUrl: '/ang/navigation'
  };
});

dnscheck.directive('tab',function(){
  return {
    restrict: 'E',
    require: '^navigation',
    transclude: true,
    scope: { tabTitle: '@', tabId: '@' },
    link: function(scope, element, attrs, tabsCtrl) {
      tabsCtrl.addPane(scope);
    },
    templateUrl: '/ang/tab'
  };
});

dnscheck.directive('domainCheck',function(){
  return {
    restrict: 'E',
    transclude: true,
    scope : { inactive: '@'},
    controller: ['$rootScope', '$scope', '$window', function($rootScope, $scope, $window){
        $scope.interval = 5000; // 5 sec retry
        $scope.form = {};
        $scope.form.ipv4 = true;
        $scope.form.ipv6 = true;
        $scope.location = $window.location.href;
        if(typeof $rootScope.language === 'undefined') $rootScope.language = navigator.language || navigator.userLanguage;

        if($scope.inactive) {
          $scope.contentUrl = '/ang/inactive_domain_check'
          $scope.ns_list = [{ns:"",ip:""}];
          //$scope.ds_list = [{algorithm:"", digest:""}];
          $scope.ds_list = [];
        }
        else $scope.contentUrl = '/ang/domain_check'

        if(typeof t_res !== 'undefined' && typeof t_res.params.nameservers === 'undefined' && ! $scope.inactive){
        // 
          $scope.form = t_res.params;
          $scope.result = t_res.results;
          $scope.test = { id: t_res.id, creation_time: t_res.creation_time};
          $.ajax('/history',{
            data : { data: JSON.stringify($scope.form) },
            dataType : 'json',
            success: function(data){
              $scope.$apply($scope.history = data.result);
            },
            error: function(){
              alert('Can\'t get test history');
            }
          });
        }
        if(typeof t_res !== 'undefined' && typeof t_res.params.nameservers !== 'undefined' && $scope.inactive){
        // 
          $scope.form = t_res.params;
          $scope.ns_list = t_res.params.nameservers;
          $scope.ds_list = t_res.params.ds_digest_pairs;
          $scope.result = t_res.results;
          $scope.test = { id: t_res.id, creation_time: t_res.creation_time};
          $.ajax('/history',{
            data : { data: JSON.stringify($scope.form) },
            dataType : 'json',
            success: function(data){
              $scope.$apply($scope.history = data.result);
            },
            error: function(){
              alert('Can\'t get test history');
            }
          });
        }

        $scope.fetchFromParent = function(){
          $.ajax('/parent',{
            data : $scope.form,
            dataType : 'json',
            success: function(data){
              $scope.$apply($scope.ns_list = data.result.ns_list);
              $scope.$apply($scope.ds_list = data.result.ds_list);
            },
            error: function(){
              alert('Can\'t get test history');
            }
          });
        };

        $scope.resolveNS = function(e,idx){
          var $ns = $(e.target).val();
          if($scope.ns_list[idx].ip !== '') return;
          $.ajax('/resolve',{
            data : {data:$ns},
            dataType : 'json',
            success: function(data){
              if(data.result.length == 1){
                $scope.$apply($scope.ns_list[idx].ip = data.result[0][$ns]);
              }
              else {
                $scope.$apply($scope.ns_list[idx].ip = data.result[0][$ns]);
                for(var i = 1; i< data.result.length; i++){
                  $scope.$apply($scope.ns_list.splice(idx,0,{ns:$ns,ip:data.result[i][$ns]}));
                }
              }
            },
            error: function(){
              alert('Can\'t resolve name');
            }
          });
        };

        $scope.exportFile = function(evt){
          var a = evt.target;
          var text = $('#adv_result').text();
          a.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
        };

        $scope.getModules = function(result){
          var modules = {};
          for( var item in result ){
            if( typeof modules[result[item].module] === 'undefined' ) modules[result[item].module] = 'check';
            if( result[item].level=='WARNING') modules[result[item].module] = 'warning';
            if( result[item].level=='ERROR') modules[result[item].module] = 'ban';
            if( result[item].level=='CRITICAL') modules[result[item].module] = 'ban';
          } 
          $scope.modules = modules;
          return Object.keys(modules);
        };

        $scope.getNS = function(result){
          var ns = {};
          for( var item in result ){
            if(typeof result[item].ns !== 'undefined') ns[result[item].ns] = 1;
          } 
          return Object.keys(ns);
        };

        $scope.getItems = function(result, module){
          var ret = [];
          for( var item in result ){
            if( result[item].module == module ) ret.push( result[item] );
          }
          return ret;
        };

        $scope.getItemsByNS = function(result, ns){
          var ret = [];
          for( var item in result ){
            if( result[item].ns == ns ) ret.push( result[item] );
          }
          return ret;
        };

        $scope.addNS = function(){
          $scope.ns_list.push({name:"",ip:""});
        };

        $scope.addDigest = function(){
          $scope.ds_list.push({algorithm:"",digest:""});
        };

        $scope.removeNS = function(idx){
          $scope.ns_list.splice(idx,1);
        };

        $scope.removeDigest = function(idx){
          $scope.ds_list.splice(idx,1);
        };

        $scope.showResult = function(){
          $('.run-btn-icon').addClass('fa-play-circle-o').removeClass('loading');
          $.ajax('/result',{
            data : { id: $scope.job_id, language: $rootScope.language },
            dataType : 'json',
            success: function(data){
              $scope.$apply($scope.test = { id: data.result.id, creation_time: data.result.creation_time});
              $scope.$apply($scope.result = data.result.results);
              $scope.$apply($scope.getModules(data.result.results));
            },
            error: function(){
              alert('Can\'t get test result');
            }
          });

          $.ajax('/history',{
            data : { data: JSON.stringify($scope.form) },
            dataType : 'json',
            success: function(data){
              $scope.$apply($scope.history = data.result);
            },
            error: function(){
              alert('Can\'t get test history');
            }
          });
        
        };
        $scope.progressCheck = function(){
          $.ajax('/progress',{
            data : { id: $scope.job_id },
            dataType : 'json',
            success: function(data){
              $scope.$apply($scope.progress = data.progress.toString());
              if(data.progress === 100){ $scope.showResult(); }
              else {
                setTimeout($scope.progressCheck, $scope.interval);
              }
            },
            error: function(){
              alert('Can\'t get test progress');
            }
          });
        };
        $scope.domainCheck = function(){
			if($scope.inactive) { 
				$scope.form.nameservers = $scope.ns_list;
				$scope.form.ds_digest_pairs = $scope.ds_list;
			}
			
			$.ajax('/check_syntax',{
				data : { data: JSON.stringify($scope.form) },
				dataType : 'json',
				success: function(data){
					alert(JSON.stringify(data.result));
					if(data.result.status === 'nok') {
						$scope.$apply($scope.showSyntaxErrors(data.result));
					}
					else {
						$scope.$apply($scope.startTest(data.result));
					}
				},
				error: function(){
					alert('Can\'t get syntax test result');
				}
			});

			$scope.startTest = function () {
				alert('Syntax OK, starting tests');
				$scope.result = null;
				if( (typeof $scope.form.domain === 'undefined') || ($scope.form.domain === '') ){
					alert('Can\'t run test for unspecified domain name');
					return;
				}
				if( $scope.inactive && ($scope.ns_list.length == 0 || typeof $scope.ns_list[0].ns === 'undefined' ||$scope.ns_list[0].ns === '')  ){
					alert('Can\'t run test without at least one nameserver specified');
					return;
				}
				$('.run-btn-icon').removeClass('fa-play-circle-o').addClass('loading');
				$.ajax('/run',{
					data : { data: JSON.stringify($scope.form) },
					type: 'post',
					dataType : 'json',
					success: function(data){
						$scope.job_id = data.job_id;
						$scope.progressCheck();
					},
					error: function(){
						alert('Can\'t run test');
					}
				});
			};
			
			$scope.showSyntaxErrors = function () {
				alert('Found Syntax Errors');
			};
		};
    }],
    template: '<div ng-include="contentUrl"></div>'
  };
});

dnscheck.directive('version',function(){
  return {
    restrict: 'E',
    transclude: true,
    scope : true,
    controller: function($scope){
      $.ajax('/version',{
        data : {},
        dataType : 'json',
        success: function(data){
          $scope.version = data.result;
        },
        error: function(){
          alert('Can\'t get version');
        }
      });
    },
    template: '{{version}}'
  };
});


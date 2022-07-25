angular.module('codemeet').controller 'advanceSettingCtrl', ['$scope','$filter','ngUser','$modalInstance','settingObj','codemeet','toast','SERVER_INTERFACE_LANGUAGE','langObj','$routeParams','INTERFACE_LANGUAGE_ZH', ($,$filter, user,$modalInstance,settingObj,codemeet,toast,SERVER_INTERFACE_LANGUAGE,langObj,$routeParams,INTERFACE_LANGUAGE_ZH) ->

  $translate = $filter('translate');
  $.settingObj=settingObj
  $.langObj=langObj
  user = user.get()
  $.indexSkip=1
  if user?.companyFeatures && user?.companyFeatures?.enableHireabilityStatusFlag && Number(user?.companyFeatures?.enableHireabilityStatusFlag)==1 
    $.enableHireabilityStatusFlag=true
    $.indexSkip=$.indexSkip+1;
  if user?.companyFeatures && user?.companyFeatures?.disableRecording && Number(user?.companyFeatures?.disableRecording)==1
    $.disableRecordingFlag=true
  if user?.companyFeatures && user?.companyFeatures?.enableFaceMatch && Number(user?.companyFeatures?.enableFaceMatch)==1
    $.enableFaceMatchFlag=true    
  if codemeet.cmmodal.get().editTest
    $.editTest=true
    
  $.languageList=codemeet.cmmodal.getLangList()
  $.showLang=false
  if SERVER_INTERFACE_LANGUAGE != INTERFACE_LANGUAGE_ZH
    $.defLang=$.langObj
    $.showLang=true
  $.populateDefLang=(value)->
    $.defLang=value

  if $routeParams.interviewSettingsId && Number($routeParams.interviewSettingsId)>0
    if $.fromNewClient
      $.viewTest=true  


  $.saveForm = ()->
    if SERVER_INTERFACE_LANGUAGE != INTERFACE_LANGUAGE_ZH
      $.langObj=$.defLang
    error=false
    angular.forEach $.settingObj, (data,key) ->
      if data.value && data.viewThreshold
        if data.data.length==0 || isNaN(data.data)
          toast.danger $translate("CODE_MEET.THRESHOLD_ERROR")+' '+key
          error=true
    if !error      
      codemeet.cmmodal.setAdvanceSettingObj(angular.copy $.settingObj)
      codemeet.cmmodal.setLangSettingObj(angular.copy $.langObj)
      $.showEmailLoading = true
      $.showSMSLoading = true    
    
      $.cancel()

  $.cancel = ->
    $modalInstance.close()
    
  
]
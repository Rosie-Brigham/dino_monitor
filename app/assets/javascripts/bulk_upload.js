core.BulkUpload = {};

$(document).on("ready page:load", function() {
  if ($('h3#bulk-upload').size() > 0) {
    core.BulkUpload.readyBulkUpload();
    core.BulkUpload.readyAutoParticipantFill()
    core.BulkUpload.readyAutoDateFill()
    core.BulkUpload.readyMultiSelect()
  } 
});

core.BulkUpload.readyBulkUpload = function() {
  console.log('fired!')
  Dropzone.options.filesField = {
    url: "/admin/bulk_upload",
    addRemoveLinks: true,
    autoProcessQueue: false,
    uploadMultiple: true,
    accept: function(file, done) {
      $("div#files-field").css({"height": "auto"});
      done();
    },
    init: function() {
      var myDropzone = this;
  
      var form = document.getElementById('dropzone-form-id');
      form.addEventListener('submit', function(event) {
        // stop the form's submit event
        if(myDropzone.getQueuedFiles().length > 0){
          event.preventDefault();
          event.stopPropagation();
          myDropzone.processQueue();
        }
      });
  
      myDropzone.on("sendingmultiple", function(file, xhr, formData) {
        var site_ids = $('.ms-selected').map((_,el) => el.firstChild.getAttribute("value")).get()
        var uniqueIds = site_ids.filter((v, p) => site_ids.indexOf(v) == p)

        var reliable = $('#tpl').find('#reliable').is(':checked')
        var date = $('#tpl').find('#record_taken').val()
        var submittedAt = $('#tpl').find('#submitted_at').val()
        var typeName = $('#tpl').find('#type_name').val()
        
        var participantId = $('#tpl').find('#participant_id').val()
        var comment = $('#tpl').find('#comment').val()
        
        formData.append("site_ids", uniqueIds);
        formData.append('reliable', reliable);
        formData.append('record_taken', date);
        formData.append('submitted_at', submittedAt);
        formData.append('type_name', typeName);
        formData.append('comment', comment);
        formData.append('participant_id', participantId);
      });
    },
    successmultiple: function(data,response) {
      $('#tpl').toggleClass('hidden')
      $('#response').toggleClass('hidden')
      
      var textnode = document.createTextNode(response);
      var div = document.getElementById('response')
      div.innerHTML += response.toString()
    }
  };
}

core.BulkUpload.readyAutoParticipantFill = function() {
  $('.participant_id').change(function(e){
    if (this.value.includes("@")) {
      $("#type_name option[value='EMAIL']").attr("selected", true);
    } else if (this.value.includes("+")) {
      $("#type_name option[value='WHATSAPP']").attr("selected", true);
    } else {
      return true
    }
 });
}

core.BulkUpload.readyAutoDateFill = function() {
  $('input#record_taken').change(function(){
    $('input#submitted_at').val(this.value)
  })
}

core.BulkUpload.readyMultiSelect = function() {
  $('#myDropzoneForm_site_ids').multiSelect({})
}
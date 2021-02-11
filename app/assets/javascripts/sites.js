core.Sites = {};

$( document ).on('turbolinks:load', function() {
  if ($('h3#site-info').size() > 0) {
    core.Sites.readySiteSubmissionTags()
    core.Sites.readyModal()
    core.Sites.readySiteNameTags()
  } 
});

core.Sites.readySiteSubmissionTags = function() {
  $('.tags').tagsInput();
}

core.Sites.readyModal = function() {
  MicroModal.init();
}

core.Sites.readySiteNameTags = function() {
  $('.site_names').tagsInput();

  // get site names
  var sites = $('span#site-name-list').text()
  var list =  ["A# .NET", "A# (Axiom)", "A-0 System", "A+"]
  var sites = sites.replace('[','')
  var sites = sites.replace(']','')
  var sites = sites.substring(1)
  var sites = sites.slice(0,-1)
  var site_names = sites.split('", "')
  
  

  $('.site_name_tags').each(function(i, obj) {
    //test
    tagify = new Tagify(obj, {
      whitelist: site_names,
      maxTags: 20,
      dropdown: {
        maxItems: 20,           // <- mixumum allowed rendered suggestions
        classname: "tags-look", // <- custom classname for this dropdown, so it could be targeted
        enabled: 0,             // <- show suggestions on focus
        closeOnSelect: false    // <- do not hide the suggestions dropdown once an item has been selected
      }
    })
  });


}
const descriptionSettings = {
  selector: '.tinymce-description',
  plugins: 'print preview paste autolink autosave save directionality code visualblocks visualchars fullscreen image link media codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists wordcount imagetools textpattern noneditable help charmap emoticons',
  menubar: 'file edit view insert format tools table help',
  toolbar: 'fontselect fontsizeselect formatselect | bold italic underline | alignleft aligncenter alignright alignjustify | outdent indent | numlist bullist | forecolor backcolor removeformat | insertfile image template link anchor',
}

const emergencySettings = {
  selector: '.tinymce-emergency',
  plugins: 'print paste autolink autosave save directionality code visualblocks visualchars image link codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists wordcount imagetools textpattern noneditable help charmap emoticons autoresize',
  menubar: 'file edit view insert format tools table help',
  toolbar: 'fontselect fontsizeselect formatselect | bold italic underline | alignleft aligncenter alignright alignjustify | outdent indent | numlist bullist | forecolor backcolor removeformat | insertfile image template link anchor',
}

const commonSettings = {
  skin: 'oxide-dark',
  toolbar_mode: 'sliding',
  branding: false,
  statusbar: false,
  imagetools_cors_hosts: ['picsum.photos'],
  autosave_ask_before_unload: true,
  autosave_interval: "30s",
  autosave_prefix: "{path}{query}-{id}-",
  autosave_restore_when_empty: false,
  autosave_retention: "2m",
  image_advtab: true,
  min_height: 875,
  max_height: 953,
  content_style: "body {background-color: white; margin-left: 25px; margin-right: 25px;}",
  content_css: '//www.tiny.cloud/css/codepen.min.css',
  importcss_append: true,
  file_picker_callback: (callback, value, meta) => file_picker_function(callback, value, meta),
};

const file_picker_function = (callback, value, meta) => {
  if (meta.filetype === 'file' || meta.filetype === 'image' || meta.filetype === 'media') {
    const input = document.createElement('input');
    input.setAttribute('type', 'file');
    input.setAttribute('accept', 'image/*');

    input.onchange = function () {
      const file = this.files[0];

      const reader = new FileReader();
      reader.onload = function () {
        /*
          Note: Now we need to register the blob in TinyMCEs image blob
          registry. In the next release this part hopefully won't be
          necessary, as we are looking to handle it internally.
        */
        const id = 'blobid' + (new Date()).getTime();
        const blobCache = tinymce.activeEditor.editorUpload.blobCache;
        const base64 = reader.result.split(',')[1];
        const blobInfo = blobCache.create(id, file, base64);
        blobCache.add(blobInfo);

        /* call the callback and populate the Title field with the file name */
        callback(blobInfo.blobUri(), {title: file.name});
      };
      reader.readAsDataURL(file);
    };
    input.click();
  }
}

tinymce.init({
  ...commonSettings, ...descriptionSettings
});

tinymce.init({
  ...commonSettings, ...emergencySettings
});

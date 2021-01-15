const descriptionSettings = {
  selector: '.tinymce-description',
  plugins: 'print preview paste autolink autosave save directionality code visualblocks visualchars fullscreen image link media codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists wordcount imagetools textpattern noneditable help charmap emoticons',
  menubar: 'file edit view insert format tools table help',
  toolbar: 'undo redo | bold italic underline strikethrough | fontselect fontsizeselect formatselect | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist | forecolor backcolor removeformat | pagebreak | charmap emoticons | fullscreen  preview save print | insertfile image media template link anchor codesample | ltr rtl',
}

const emergencySettings = {
  selector: '.tinymce-emergency',
  plugins: 'print preview paste autolink autosave save directionality code visualblocks visualchars fullscreen image link media codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists wordcount imagetools textpattern noneditable help charmap emoticons',
  menubar: 'file edit view insert format tools table help',
  toolbar: 'undo redo | bold italic underline strikethrough | fontselect fontsizeselect formatselect | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist | forecolor backcolor removeformat | pagebreak | charmap emoticons | fullscreen  preview save print | insertfile image media template link anchor codesample | ltr rtl',
}

const commonSettings = {
  branding: false,
  imagetools_cors_hosts: ['picsum.photos'],
  toolbar_sticky: true,
  autosave_ask_before_unload: true,
  autosave_interval: "30s",
  autosave_prefix: "{path}{query}-{id}-",
  autosave_restore_when_empty: false,
  autosave_retention: "2m",
  image_advtab: true,
  content_css: '//www.tiny.cloud/css/codepen.min.css',
  importcss_append: true,
  file_picker_callback: (callback, value, meta) => file_picker_function(callback, value, meta),
  toolbar_mode: 'sliding',
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
  ...descriptionSettings, ...commonSettings
});

tinymce.init({
  ...emergencySettings, ...commonSettings
});

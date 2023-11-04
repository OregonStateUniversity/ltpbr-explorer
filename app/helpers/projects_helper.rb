module ProjectsHelper

  def help_button(dom_id)
    tag.div id: dom_id, class: 'btn btn-question' do
      tag.i class: 'fa fa-question-circle-o', 'aria-hidden': 'true'
    end
  end

  FORM_HELP_MODAL_ATTRIBUTES = [
    {
      id: 'name-modal',
      title: 'Project Name',
      body_lines: [
        'Just a simple name for the project e.g:',
        '"Bear Creek Surface Flow Enhancement", or',
        '"Bridge Creek Riparian Uplift"'
      ]
    },
    {
      id: 'cover-photo-modal',
      title: 'Cover Photo',
      body_lines: [
        'Upload one representative photo of the project area, channel, or structures.',
        'The photo must be below 50 MB in size and be in the JPEG, PNG, GIF, BMP, AVIF, or WebP format.',
        'The cover photo will be the first photo displayed everywhere.'
      ]
    },
    {
      id: 'photo-modal',
      title: 'Project Photos',
      body_lines: [
        'Upload at least one representative photo of the project area, channel, or structures.',
        'Each of the photos must be below 50 MB in size and be in the JPEG, PNG, GIF, BMP, AVIF, or WebP format.',
        'There is a limit of 20 photos.'
      ]
    },
    {
      id: 'stream_name-modal',
      title: 'Stream Name',
      body_lines: [
       'Name of the project stream. e.g. Bridge Creek.'
      ]
    },
    {
      id: 'watershed-modal',
      title: 'Watershed Name',
      body_lines: [
       'Project watershed or sub-watershed. e.g. "John Day"'
      ]
    },
    {
      id: 'url-modal',
      title: 'Project URL',
      body_lines: [
       'Outside link to existing project. e.g. "https://www.anabranchsolutions.com/beaver-dam-analogs.html"'
      ]
    },
    {
      id: 'manage-affiliations-modal',
      title: 'Organizations',
      body_lines: [
        'Add or remove affiliated organizations for this project.',
        'Roles can be applied to each organization, e.g. "Founder", after Project creation on project page through "Manage Affiliations".'
      ]
    },
    {
      id: 'affiliation-modal',
      title: 'Affiliated Organizations',
      body_lines: [
       'Organizations involved with project design and implementation. Organizations\' role can be modified in subsequent Affiliations form
               page found on Project page after submission.'
      ]
    },
    {
      id: 'implementation_date-modal',
      title: 'Implementation date',
      body_lines: [
       'Approximate date of initial structure installation.'
      ]
    },
    {
      id: 'latitude-modal',
      title: 'Latitude',
      body_lines: [
       'Approximate project LATITUDE in decimal degrees (e.g., 44.23454).'
      ]
    },
    {
      id: 'longitude-modal',
      title: 'Longitude',
      body_lines: [
       'Approximate project LONGITUDE in decimal degrees (e.g., -122.3456).'
      ]
    },
    {
      id: 'number_of_structures-modal',
      title: 'Number of Structures',
      body_lines: [
       'Approximate number of structures currently installed or that will be installed in the future.'
      ]
    },
    {
      id: 'treatment_length-modal',
      title: 'Treatment length',
      body_lines: [
       'Approximate length of stream being treated with LT-PBR structures in meters.'
      ]
    },
    {
      id: 'narrative-modal',
      title: 'Narrative',
      body_lines: [
       'Briefly describe restoration goals for the project which may include increased fish habitat, riparian expansion, channel aggradation, etc...'
      ]
    },
    {
      id: 'primary_contact-modal',
      title: 'Primary Contact',
      body_lines: [
       'Primary contact name for project manager or coordinator. e.g. John Doe'
      ]
    },
    {
      id: 'structure_description-modal',
      title: 'Structure Design Elements',
      body_lines: [
       'Briefly describe LT-PBR structure design and/or construction elements. e.g., Structures were primarily BDAs, and generally built at a low elevation of 0.25 m. Majority of the structures utilized two post rows and juniper and sagebrush as fill material.'
      ]
    },
    {
      id: 'cover-photo-modal',
      title: 'Cover Photo',
      body_lines: [
        'Select an existing photo to be the cover photo for this project.',
        'This photo will be used as the thumbnail in the projects list and projects map.'
      ]
    },
    {
      id: 'delete-photos-modal',
      title: 'Photo Deletion',
      body_lines: [
        'Select existing photos to delete from this project.',
        'Multiple photos can be selected for deletion.'
      ]
    }
  ]

end

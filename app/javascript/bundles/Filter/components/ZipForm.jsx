import React from 'react';

export default class ZipForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      view: 'di'
    }
  }

  handleSubmit = event => {
    event.preventDefault()
    console.log("FiReD")
    this.setState({view: 'dn'})

    const {email} = this.props
    const {site} = this.props
    const {type} = this.props    
    const {tags} = this.props

    var stringTags = (!tags.length) ? "" : tags.map(obj => { return obj.label})
    
    const url = `api/v1/zip_images?site_name=${site}&email=${email}&type=${type}&tags=${stringTags}`

    fetch(url)
      .then(response => response.json())
      .then(data => console.log(data, "This is the data"))
      .catch(error => console.log(error))
    
    alert("Your images are being processed, depending on how many images you have selected this may take a long time. Please leave up to an hour before re-submitting another job")
  }


  render() {
    return (
      <div className={"h-25 w-100 flex flex-column"}>
        <button className={"mt4 white-background dark-color w-100 centre " + this.state.view } type="submit" onClick={this.handleSubmit}>
          Zip images
        </button>
        <p className="f6">
          This will collect your selected images and zip them into a compressed file. These will then be emailed to your login address.
          Please leave up to an hour for this process, depending on how many images you have selected
        </p>
      </div>
    )
  }
}
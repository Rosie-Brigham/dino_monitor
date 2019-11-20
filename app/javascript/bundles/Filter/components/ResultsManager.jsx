import React from 'react';
import 'babel-polyfill';

import Submission from './Submission.jsx'
import Pagination from './Pagination.jsx'
import Compare from './Compare.jsx'

export default class ResultsManager extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      imageCompare: [],
      compareHeight: 0,
      compareWidth: 0, // this is to set the height of the image on the compare modal
      pageSize: 20, // how many submissons per page
    };
  }
  
  handlePaginationUrl = (event) => {
    event.preventDefault()
    const pageUrl = event.target.href
    this.props.refineView({url: pageUrl})
  }
  
  handlePaginationCount = event => {
    event.preventDefault()
    const pageSize = event.target.innerHTML
    this.setState({pageSize: pageSize})
    this.props.refineView({size: pageSize})
  }
  
  handleSelectCompare = event => {
    const images = this.state.imageCompare
    const imageUrl = event.target.value

    const image = event.target.closest('#submission-card').querySelectorAll('img')[0]
    const width = image.naturalWidth
    const height = image.naturalHeight

    var filteredImages = images
    if (images.includes(imageUrl)) {
      filteredImages = filteredImages.filter(image => image !== imageUrl)
    } else {
      if (images.length > 1) {
        alert("You can only select two images at a time!")
        event.preventDefault()
      } else {
        filteredImages.push(imageUrl)
      }
    }
    
    this.setState({
      imageCompare: filteredImages,
      compareHeight: width,
      compareWidth: height,
    })
  }

 

  render() {
    const {totalSubmissions} = this.props
    const {pageNumber} =  this.props
    const {pageSize} = this.state
    const {links} = this.props
    const pageNumbers = Math.round(Number(totalSubmissions) / Number(pageSize))

    return (
      <div className="ui raised segment no padding">
        <div className="sticky w-100 z-3">
          {/* <Form refineView={this.refineView} siteNames={this.props.siteNames}/> */}
          <Compare imageCompare={this.state.imageCompare} compareHeight={this.state.compareHeight} compareWidth={this.state.compareWidth}/>
        </div>
        
        <span className="mh2">{totalSubmissions} submissions found, page {pageNumber} of {pageNumbers}.</span>
        
        <ul className="list flex flex-wrap items-center pa0 ma0">
          <li className="pointer mh2 tc">Navigate to:</li>
          { Object.keys(links).map((keyName, i) => ( 
            <Pagination 
              direction={keyName}
              link={links[keyName]}
              handlePagination={this.handlePaginationUrl}
              key={i} />
            ))}
        </ul>
        
        <ul className="list flex flex-wrap items-center pa0 ma0 mb4">
          <li className="pointer mh2 tc">Show per page:</li>
          <li className="pointer mh2 tc"><a onClick={this.handlePaginationCount}>20</a></li>
          <li className="pointer mh2 tc"><a onClick={this.handlePaginationCount}>50</a></li>
          <li className="pointer mh2 tc"><a onClick={this.handlePaginationCount}>100</a></li>
        </ul>

        <div className="w-100-l relative z-1">
          <div className="flex flex-wrap justify-between submissions ph3 ph4-l">
              {this.props.submissions.map((submission, i)=>(<Submission {...submission} key={i} handleSelectCompare={this.handleSelectCompare} />))}
          </div>
        </div>
      </div>
    )
  }
}
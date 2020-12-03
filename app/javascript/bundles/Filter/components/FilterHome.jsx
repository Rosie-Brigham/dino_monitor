import PropTypes from 'prop-types';
import React from 'react';
import ResultsManager from './ResultsManager.jsx'
import SubmissionsContextProvider from './SubmissionContext.jsx'
import DataVisConsole from './DataVisConsole.jsx'
import Nav from './Nav.jsx'

export default class FilterHome extends React.Component {
  static propTypes = {
    groupNames: PropTypes.array.isRequired,
    siteNames: PropTypes.array.isRequired, // this is passed from the Rails view
    tags: PropTypes.array.isRequired,
    userEmail: PropTypes.string.isRequired
  };

  /**
   * @param props - Comes from your rails view.
   */
  constructor(props) {
    super(props);
    this.state = {     
      siteGroup: '',
      site: '',
      type: '',
      tags: '',
      reliable: false, 
      submissions: [],
      links: [],
      allSubmissionsTotal: '', // Popoulated on the first call, and stays that way for dashboard
      totalSubmissions: '', // how many submissions there are
      pageNumber: '', // what page we're on at the moment
      viewDataVis: false, // viewing submissions or data view
      navCollapsed: false,
      submissionsData: [],
    };

    // doing all of the binding
    this.handleToggle = this.handleToggle.bind(this);
  }

  async componentDidMount() {
    try {
      const response = await fetch('api/v1/submissions')
      if (!response.ok) {
        throw Error(response.statusText)
      }
      const json = await response.json()
      const total = await response.headers.get("Total")

      this.setState({
        submissions: json.data,
        allSubmissionsTotal: total,
        totalSubmissions: total,
        pageNumber: '1',
        links: json.links
      })
    } catch (error) {
      console.log(error)
    }
  }

  // this refines the view, collecting the images and or data to show
  refineView = async ({reliable=this.state.reliable, 
                       siteGroup=this.state.siteGroup,
                       site=this.state.site, 
                       type=this.state.type, 
                       tags=this.state.tags,
                       size=this.state.pageSize,
                       pageNumber=this.state.pageNumber,
                       url="",
                       dataOnly=this.state.viewDataVis}) => {
    try {
      const endpoint = dataOnly ? 'api/v1/submission_data' : 'api/v1/submissions'
      const requestURL = url ? url : `${endpoint}?reliable=${reliable}&site_group_filter=${siteGroup}&site_filter=${site}&type_filter=${type}&tags=${tags}&bespoke_size=${size}&page=${pageNumber}`
      const response = await fetch(requestURL)
      if (!response.ok) {
      throw Error(response.statusText)
    }
      const json = await response.json()
      const total = await response.headers.get("Total")
      const newPageNumber = await response.headers.get("current-page")
      
      // Sets the state of the page wide variables
      this.setState({
        reliable: reliable,
        siteGroup: siteGroup,
        site: site, 
        type: type, 
        tags: tags
      })
      
      // set state if data is returned
      if (dataOnly || this.state.viewDataVis) {
        this.setState({ submissionsData: json,
                        viewDataVis: true})
      } else {
        // Set state if images are returned
        this.setState({
          submissions: json.data,
          pageSize: size, 
          totalSubmissions: total,
          pageNumber: newPageNumber
        })
        json.links && this.setState({links: json.links})
      }
      
    } catch (error) {
      console.log(error)
    }
  }

  handleToggle = event => {
    const target = event.target.textContent
    if (target == "Data") {
      this.refineView({reliable: this.state.reliable, 
                       site: this.state.site, 
                       type: this.state.type,
                       dataOnly: true})
    } else if (target == "Images") {
      this.setState({viewDataVis: false})
      this.refineView({dataOnly: false})
    }
  }

  handleToggleNav = () => {
    this.setState({navCollapsed: !this.state.navCollapsed});
  }
  
  render() {
    const {navCollapsed} = this.state
    let data
    if (this.state.viewDataVis) { 
      data = <DataVisConsole 
              className={navCollapsed ? "collapsed" : "full"}
              submissionsData={this.state.submissionsData}
              allSubmissionsTotal={this.state.allSubmissionsTotal}
              siteName={this.state.site}/>
    } else {
      data = <ResultsManager 
                siteNames={this.props.siteNames} 
                tags={this.props.tags}
                submissions={this.state.submissions} 
                links={this.state.links} 
                totalSubmissions={this.state.totalSubmissions}
                pageNumber={this.state.pageNumber}
                refineView={this.refineView}
                updateState={this.updateState} />
    }


    return (
      <div>
        <SubmissionsContextProvider>
          <Nav 
            viewDataVis={this.state.viewDataVis}
            handleToggle={this.handleToggle}
            refineView={this.refineView}
            siteNames={this.props.siteNames}
            groupNames={this.props.groupNames}
            tags={this.props.tags}
            handleToggleNav={this.handleToggleNav}
            navCollapsed={this.state.navCollapsed}
            userEmail={this.props.userEmail}
             />
          <main className={navCollapsed ? "collapsed ph4" : "full ph4"}>
            {data}
          </main>
        </SubmissionsContextProvider>
      </div>
    );
  }
}



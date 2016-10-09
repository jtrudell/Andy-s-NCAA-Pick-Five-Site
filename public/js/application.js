'use strict';

var Headline = React.createClass({
  displayName: 'Headline',

  render: function render() {
    // to come: startYear will be generated when new season begins
    var startYear = 2016;
    var endYear = startYear + 1;

    return React.createElement(
      'div',
      {className: 'headline center'},
      React.DOM.h1(null, 'NCAA Pick Five Challenge'),
      React.DOM.h2(null, startYear + '/' + endYear )
    );
  }
});

ReactDOM.render(
  React.createElement(Headline, null),
  document.querySelector('.headline')
);

$(document).ready(function(){
    $('.collapsible').collapsible({
      accordion : true
    });
  });

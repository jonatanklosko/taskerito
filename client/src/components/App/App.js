import React from 'react';
import { BrowserRouter as Router } from 'react-router-dom';
import { CssBaseline } from '@material-ui/core';
import { ThemeProvider } from '@material-ui/core/styles';
import { ApolloProvider } from '@apollo/client';
import { ConfirmProvider } from 'material-ui-confirm';
import { client } from './apollo';
import { theme } from './theme';
import Navigation from '../Navigation/Navigation';

function App() {
  return (
    <ThemeProvider theme={theme}>
      <ConfirmProvider>
        <Router>
          <ApolloProvider client={client}>
            <CssBaseline />
            <Navigation />
          </ApolloProvider>
        </Router>
      </ConfirmProvider>
    </ThemeProvider>
  );
}

export default App;

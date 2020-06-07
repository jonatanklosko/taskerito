import React from 'react';
import { useApolloClient } from '@apollo/client';
import { useHistory } from 'react-router-dom';
import { Button } from '@material-ui/core';
import { clearToken } from '../../lib/auth';

function SignOutButton() {
  const client = useApolloClient();
  const history = useHistory();

  function handleSignOut() {
    clearToken();
    history.push('/');
    client.resetStore();
  }

  return (
    <Button
      variant="outlined"
      size="small"
      color="secondary"
      onClick={handleSignOut}
    >
      Sign out
    </Button>
  );
}

export default SignOutButton;

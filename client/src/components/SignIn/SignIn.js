import React from 'react';
import { Typography, Grid, Button } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';

const useStyles = makeStyles((theme) => ({}));

function SignIn() {
  const classes = useStyles();

  return (
    <div>
      <Typography variant="h5">Sign in</Typography>
    </div>
  );
}

export default SignIn;

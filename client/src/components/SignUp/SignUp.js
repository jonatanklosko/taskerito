import React from 'react';
import { useMutation, gql } from '@apollo/client';
import { Typography, Grid, Button, TextField } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import SignUpForm from './SignUpForm';
import welcome from './welcome.svg';

const useStyles = makeStyles((theme) => ({
  image: {
    height: 128,
    maxWidth: '100%',
  },
  content: {
    minWidth: '40%',
    [theme.breakpoints.down('sm')]: {
      minWidth: '100%',
    },
  },
  formContainer: {
    width: '100%',
  },
}));

const SIGN_UP = gql`
  mutation SignUp($input: SignUpInput!) {
    signUp(input: $input) {
      successful
      result {
        token
      }
    }
  }
`;

function SignUp() {
  const classes = useStyles();
  const [signUp, { data }] = useMutation(SIGN_UP);
  console.log(data);

  return (
    <Grid container direction="column" spacing={3} alignItems="center">
      <Grid item>
        <img src={welcome} className={classes.image} />
      </Grid>
      <Grid item className={classes.content}>
        <Grid container direction="column" alignItems="flex-start" spacing={2}>
          <Grid item>
            <Typography variant="h5">Sign up</Typography>
          </Grid>
          <Grid item className={classes.formContainer}>
            <SignUpForm
              onSubmit={(data) => signUp({ variables: { input: data } })}
            />
          </Grid>
        </Grid>
      </Grid>
    </Grid>
  );
}

export default SignUp;

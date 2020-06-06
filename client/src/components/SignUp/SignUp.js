import React from 'react';
import { useHistory } from 'react-router-dom';
import { useMutation, gql } from '@apollo/client';
import { Typography, Grid } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import SignUpForm from './SignUpForm';
import welcome from './welcome.svg';
import { optionalGet } from '../../lib/utils';
import { storeToken } from '../../lib/auth';

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
      messages {
        field
        message
        code
      }
      result {
        token
      }
    }
  }
`;

function SignUp() {
  const classes = useStyles();
  const history = useHistory();
  const [signUp, { data, loading }] = useMutation(SIGN_UP, {
    onCompleted: ({ signUp: { successful, result } }) => {
      if (successful) {
        storeToken(result.token);
        history.push('/');
      }
    },
  });

  return (
    <Grid container direction="column" spacing={3} alignItems="center">
      <Grid item>
        <img src={welcome} alt="" className={classes.image} />
      </Grid>
      <Grid item className={classes.content}>
        <Grid container direction="column" alignItems="flex-start" spacing={2}>
          <Grid item>
            <Typography variant="h5">Sign up</Typography>
          </Grid>
          <Grid item className={classes.formContainer}>
            <SignUpForm
              disabled={loading}
              validationErrors={optionalGet(data, 'signUp.messages')}
              onSubmit={(data) => signUp({ variables: { input: data } })}
            />
          </Grid>
        </Grid>
      </Grid>
    </Grid>
  );
}

export default SignUp;

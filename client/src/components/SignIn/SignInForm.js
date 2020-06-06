import React from 'react';
import { Grid, Button, TextField } from '@material-ui/core';
import { Alert } from '@material-ui/lab';
import { useForm } from 'react-hook-form';
import { optionalGet } from '../../lib/utils';

function SignInForm({ disabled, onSubmit, failed }) {
  const { register, handleSubmit, errors } = useForm();

  function handleValidSubmit(data) {
    onSubmit(data);
  }

  return (
    <form onSubmit={handleSubmit(handleValidSubmit)}>
      <Grid container direction="column" spacing={2}>
        {failed && (
          <Grid item>
            <Alert severity="error">Invalid combination, sorry!</Alert>
          </Grid>
        )}
        <Grid item>
          <TextField
            fullWidth
            label="Username"
            variant="outlined"
            name="username"
            spellCheck={false}
            inputRef={register({
              required: 'Username is required.',
            })}
            error={!!errors.username}
            helperText={optionalGet(errors, 'username.message')}
            disabled={disabled}
          />
        </Grid>
        <Grid item>
          <TextField
            fullWidth
            label="Password"
            type="password"
            variant="outlined"
            name="password"
            inputRef={register({
              required: 'Password is required.',
            })}
            error={!!errors.password}
            helperText={optionalGet(errors, 'password.message')}
            disabled={disabled}
          />
        </Grid>
        <Grid item>
          <Button
            type="submit"
            variant="contained"
            color="primary"
            disabled={disabled}
          >
            Let's go!
          </Button>
        </Grid>
      </Grid>
    </form>
  );
}

export default SignInForm;

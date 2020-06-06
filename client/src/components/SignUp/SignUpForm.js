import React from 'react';
import { Grid, Button, TextField } from '@material-ui/core';
import { useForm } from 'react-hook-form';
import { optionalGet } from '../../lib/utils';

function SignUpForm({ onSubmit }) {
  const { register, handleSubmit, errors } = useForm();

  function handleValidSubmit(data) {
    onSubmit(data);
  }

  return (
    <form onSubmit={handleSubmit(handleValidSubmit)}>
      <Grid container direction="column" spacing={2}>
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
          />
        </Grid>
        <Grid item>
          <TextField
            fullWidth
            label="Name"
            variant="outlined"
            name="name"
            inputRef={register({
              required: 'Name is required.',
            })}
            error={!!errors.name}
            helperText={optionalGet(errors, 'name.message')}
          />
        </Grid>
        <Grid item>
          <TextField
            fullWidth
            label="Email"
            variant="outlined"
            name="email"
            inputRef={register({
              required: 'Email is required.',
              pattern: {
                value: /^.+@.+\..+$/i,
                message: 'Invalid email.',
              },
            })}
            error={!!errors.email}
            helperText={optionalGet(errors, 'email.message')}
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
              minLength: {
                value: 8,
                message: 'Password must be at least 8 characters long.',
              },
            })}
            error={!!errors.password}
            helperText={optionalGet(errors, 'password.message')}
          />
        </Grid>
        <Grid item>
          <Button type="submit" variant="contained" color="primary">
            Let's go!
          </Button>
        </Grid>
      </Grid>
    </form>
  );
}

export default SignUpForm;

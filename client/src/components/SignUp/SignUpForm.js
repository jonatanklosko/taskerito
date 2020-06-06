import React, { useEffect } from 'react';
import { Grid, Button, TextField } from '@material-ui/core';
import { useForm } from 'react-hook-form';
import { optionalGet } from '../../lib/utils';

function SignUpForm({ disabled, onSubmit, validationErrors }) {
  const { register, handleSubmit, errors, setError } = useForm();

  useEffect(() => {
    if (!validationErrors) return;
    validationErrors.forEach(({ field, code, message }) => {
      setError(field, code, message);
    });
  }, [validationErrors, setError]);

  function handleValidSubmit(data) {
    onSubmit(data);
  }

  return (
    <form onSubmit={handleSubmit(handleValidSubmit)}>
      <Grid container direction="column" spacing={2}>
        <Grid item>
          <TextField
            fullWidth
            autoComplete="username"
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
            autoComplete="name"
            label="Name"
            variant="outlined"
            name="name"
            inputRef={register({
              required: 'Name is required.',
            })}
            error={!!errors.name}
            helperText={optionalGet(errors, 'name.message')}
            disabled={disabled}
          />
        </Grid>
        <Grid item>
          <TextField
            fullWidth
            autoComplete="email"
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
            disabled={disabled}
          />
        </Grid>
        <Grid item>
          <TextField
            fullWidth
            autoComplete="new-password"
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

export default SignUpForm;

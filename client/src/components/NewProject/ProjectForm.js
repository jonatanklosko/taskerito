import React from 'react';
import { Grid, Button, TextField } from '@material-ui/core';
import { Alert } from '@material-ui/lab';
import { useForm } from 'react-hook-form';
import { optionalGet } from '../../lib/utils';

function ProjectForm({ disabled, onSubmit, failed }) {
  const { register, handleSubmit, errors } = useForm();

  function handleValidSubmit(data) {
    onSubmit(data);
  }

  return (
    <form onSubmit={handleSubmit(handleValidSubmit)} autoComplete="off">
      <Grid container direction="column" spacing={2}>
        {failed && (
          <Grid item>
            <Alert severity="error">Something went wrong :(</Alert>
          </Grid>
        )}
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
            disabled={disabled}
          />
        </Grid>
        <Grid item>
          <TextField
            fullWidth
            multiline
            label="Description"
            variant="outlined"
            name="description"
            inputRef={register({
              required: 'Description is required.',
              maxLength: {
                value: 250,
                message: 'Description must have at most 250 characters.',
              },
            })}
            error={!!errors.description}
            helperText={optionalGet(errors, 'description.message')}
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
            Create
          </Button>
        </Grid>
      </Grid>
    </form>
  );
}

export default ProjectForm;

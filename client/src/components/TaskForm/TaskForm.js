import React from 'react';
import {
  Grid,
  Button,
  TextField,
  FormControl,
  FormControlLabel,
  RadioGroup,
  FormLabel,
  Radio,
} from '@material-ui/core';
import { Alert } from '@material-ui/lab';
import { useForm, Controller } from 'react-hook-form';
import { optionalGet } from '../../lib/utils';
import { prioritiesData } from '../../lib/priorities';

function TaskForm({
  onSubmit,
  disabled = false,
  failed = false,
  initialData = {},
  submitText = 'Save',
}) {
  const { register, control, handleSubmit, errors } = useForm({
    defaultValues: initialData,
  });

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
            })}
            error={!!errors.description}
            helperText={optionalGet(errors, 'description.message')}
            disabled={disabled}
          />
        </Grid>
        <Grid item>
          <FormControl>
            <FormLabel>Priority</FormLabel>
            <Controller
              as={
                <RadioGroup>
                  {prioritiesData.map(({ value, label }) => (
                    <FormControlLabel
                      key={value}
                      value={value}
                      control={<Radio />}
                      label={label}
                      disabled={disabled}
                    />
                  ))}
                </RadioGroup>
              }
              defaultValue={3}
              name="priority"
              onChange={([event, value]) => parseInt(value, 10)}
              rules={{ required: true }}
              control={control}
            />
          </FormControl>
        </Grid>
        <Grid item>
          <Button
            type="submit"
            variant="contained"
            color="primary"
            disabled={disabled}
          >
            {submitText}
          </Button>
        </Grid>
      </Grid>
    </form>
  );
}

export default TaskForm;

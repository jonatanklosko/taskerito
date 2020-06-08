import React, { useState } from 'react';
import { useQuery, gql } from '@apollo/client';
import { TextField } from '@material-ui/core';
import { Autocomplete } from '@material-ui/lab';
import useDebounce from '../../hooks/useDebounce';

const USERS = gql`
  query Users($filter: String!) {
    users(filter: $filter) {
      id
      username
    }
  }
`;

function UserSearch({ onChange, TextFieldProps }) {
  const [search, setSearch] = useState('');
  const debouncedSearch = useDebounce(search, 250);

  const { data, loading } = useQuery(USERS, {
    variables: { filter: debouncedSearch },
  });

  const users = data ? data.users : [];

  return (
    <Autocomplete
      freeSolo
      options={users}
      getOptionLabel={(user) => user.username}
      loading={loading}
      onInputChange={(event, value, reason) => {
        if (reason === 'input') {
          setSearch(value);
        }
      }}
      onChange={(event, user) => onChange(user)}
      renderInput={(params) => <TextField {...params} {...TextFieldProps} />}
    />
  );
}

export default UserSearch;

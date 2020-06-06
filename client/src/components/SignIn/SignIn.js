import React from 'react';
import { useHistory } from 'react-router-dom';
import { useMutation, gql } from '@apollo/client';
import signInImage from './sign-in.svg';
import { storeToken } from '../../lib/auth';
import CenteredFormContainer from '../CenteredFormContainer/CenteredFormContainer';
import SignInForm from './SignInForm';

const SIGN_IN = gql`
  mutation SignIn($username: String!, $password: String!) {
    signIn(username: $username, password: $password) {
      successful
      result {
        token
      }
    }
  }
`;

function SignIn() {
  const history = useHistory();
  const [signIn, { data, loading }] = useMutation(SIGN_IN, {
    onCompleted: ({ signIn: { successful, result } }) => {
      if (successful) {
        storeToken(result.token);
        history.push('/');
      }
    },
  });

  return (
    <CenteredFormContainer svgImage={signInImage} title="Sign in">
      <SignInForm
        disabled={loading}
        failed={data && !data.signIn.successful}
        onSubmit={({ username, password }) =>
          signIn({ variables: { username, password } })
        }
      />
    </CenteredFormContainer>
  );
}

export default SignIn;

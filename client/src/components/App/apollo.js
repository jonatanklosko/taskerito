import { ApolloClient, HttpLink, InMemoryCache } from '@apollo/client';
import { setContext } from '@apollo/link-context';
import { getToken } from '../../lib/auth';

const httpLink = new HttpLink({
  uri:
    process.env.NODE_ENV === 'production'
      ? '/api'
      : 'http://localhost:4000/api',
});

const authLink = setContext((_, { headers }) => {
  const token = getToken();
  return {
    headers: {
      ...headers,
      authorization: token ? `Bearer ${token}` : undefined,
    },
  };
});

export const client = new ApolloClient({
  cache: new InMemoryCache(),
  link: authLink.concat(httpLink),
});

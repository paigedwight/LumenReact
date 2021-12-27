/** @format */

import type { NextPage } from 'next';
// import Head from 'next/head'
// import Image from 'next/image'
// import styles from '../styles/Home.module.css'

interface Props {
    content?: string;
}

const Home: NextPage<Props> = ({ content }) => {
    return <div>{content}</div>;
};

export const getServerSideProps = async () => {
    const version = await fetch(`http://nginx/api/`)
        .then(response => response.json())
        .then(data => data.version);

    return {
        props: { content: version },
    };
};

export default Home;

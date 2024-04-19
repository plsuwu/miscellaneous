/* ---------------------------------------------------
 * funny script to display the typing dots on discord
 * without actually typing.
 * ---------------------------------------------------
 */

let secs = 60; // length of runtime
let i = 0;
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const token = (webpackChunkdiscord_app.push([
    [''],{},(e) => {
        m = []; for (let c in e.c) m.push(e.c[c]);
    },]),m)
    .find((m) => m?.exports?.default?.getToken !== void 0)
    .exports.default.getToken();

let channel = SelectedChannelStore.getChannelId();

const type = async () => {
    const _res = await fetch(
        `https://discord.com/api/v9/channels/${channel}/typing`,
        {
            method: 'POST',
            body: null,
            headers: {
                Authorization: `${token}`,
            },
        }
    );

    return null;
};

do {
    console.log(`${i}/${secs} secs`);
    await type();
    await sleep(1000);
    ++i;
} while (i < secs);

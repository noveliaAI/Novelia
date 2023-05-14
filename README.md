<h1 align='center'>Novelia.ai</h1>
<h2>About</h2>
<li>Novelia.ai is a web3.0 social-fi platform powered by bnb chain.</li>
<li>Our service provide GPT service that anyone can be a web novel writer.</li>
<li>Creator can deploy their own SBT contract via our platform which used in SBT gated access for the contents.</li>
<li>Creator owns SBT contract and can earn profits from readers (subscription and donation)</li>
<h2>Codes</h2>
<p>Because of NDA we do not provide our front-end code; however, we provide all smart contract codes which will be used in our platform.</p>
<p>1. contracts/NovelToken.sol</p>
<ul><li>Standard ERC-20 token, upgradable and ownable.</li></ul>
<ul><li>NOVEL token is a utility token that can be used in Novelia.ai platform. </li></ul>
<ul><li>NOVEL token can be used as subscribing author's novel collection, and donate to author.</li></ul>
<p>2. contracts/NOVELIACollectionSBT.sol</p>
<ul><li>Standard ownable ERC-721 token, so called Soul Bound Token.</li></ul>
<ul><li>Novelia collection SBT is non-transferable and each wallet can own only 1 token.</li></ul>
<ul><li>Author will be deploy this smart contract and own this contract.</li></ul>
<ul><li>Functions</li></ul>
<ul><ul><li>function changeMintPrice(uint256 _mintPrice)</li></ul></ul>
<ul><ul>- Change mint price of collection SBT.</ul></ul>
<ul><ul><li>function mint()</li></ul></ul>
<ul><ul>- User call this function to mint author's collection SBT.</ul></ul>
<ul><ul>- Require $NOVEL balance equal or more than mint price.</ul></ul>
<ul><ul><li>function donate(uint256 amount)</li></ul></ul>
<ul><ul>- User call this function to donate $NOVEL token to author.</ul></ul>
<ul><ul>- This function send $NOVEL token to contract address.</ul></ul>
<ul><ul><li>function claim()</li></ul></ul>
<ul><ul>- Owner of the contract (Author) call this function to withdraw fund from smart contract.</ul></ul>
<ul><ul>- This function withdraw $NOVEL token to owner except platform fee.</ul></ul>
<p>3. contracts/NoveliaProfileSBT.sol</p>
<ul><li>Standard ownable ERC-721 token, so called Soul Bound Token.</li></ul>
<ul><li>Novelia profile SBT is non-transferable and each wallet can own only 1 token.</li></ul>
<ul><li>User will mint this SBT to use Novelia.ai platform.</li></ul>
<ul><li>To prevent bot or any kind of abusement, user need to pay certain amount of BNB to mint this SBT.</li></ul>
<ul><li>After mint this SBT, user will get unique identifer, so called handle that can be used in platform as an identifier.</li></ul>
<h2>Please refer to <a href="https://novelia-ai.gitbook.io/novelia.ai/">https://novelia-ai.gitbook.io/novelia.ai/</a> for more information.</h2>




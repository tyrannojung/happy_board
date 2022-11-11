<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="include/header.jsp"%>
    <script src="/common/js/ethers-v5.min.js"></script>
</head>
<body>
test
<script>
    var randomSeed = ethers.Wallet.createRandom();
    var privateKey = randomSeed.privateKey;
    var address = randomSeed.address;
    var mnemonic = randomSeed.mnemonic.phrase;

    console.log(randomSeed);
    console.log(privateKey);
    console.log(address);
    console.log(mnemonic);

    var restore = new ethers.Wallet(privateKey);
    console.log(restore);
    var address = restore.address;
    console.log(address);
</script>
</body>
</html>
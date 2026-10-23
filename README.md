# Privacy-Preserving Document Verification using Zero-Knowledge Proofs

A collaborative Summer Research Internship research project that enables users to prove specific facts about their documents without revealing the document itself.

## Project Overview

Traditional document verification requires users to share complete documents, exposing sensitive personal information such as names, dates of birth, addresses, identification numbers, and academic records.

This project uses **Zero-Knowledge Proofs (ZKPs)** to allow users to prove selected claims about a document while keeping the original document private.

The system combines:

- OCR-based document processing
- Attribute extraction
- Circom circuits
- Groth16 proof generation
- Cryptographic proof verification

to achieve privacy-preserving document verification.

---

## Problem Statement

In conventional verification systems:

- Complete documents must be shared
- Sensitive information is exposed unnecessarily
- Verifiers gain access to data unrelated to the requested verification

For example:

To prove:

- Age ≥ 18

A user typically shares an entire identity document, revealing:

- Full name
- Date of birth
- Address
- Document number

This violates the principle of minimum disclosure.

---

## Proposed Solution

The proposed system allows users to:

1. Upload a document
2. Select verification claims
3. Generate a Zero-Knowledge Proof
4. Download proof files
5. Share only the proof files with a verifier

The verifier can then:

1. Upload the proof files
2. Verify the proof cryptographically
3. Confirm the claim is true

without accessing the original document.

---

## Key Features

### Privacy-Preserving Verification

Verify document attributes without revealing the document itself.

### OCR-Based Processing

Automatically extracts information from:

- PDF documents
- Image documents

### Supported Claims

#### Aadhaar Documents

- Name Verification
- Age ≥ 18 Verification
- Gender Verification
- Multi-Attribute Verification

#### Academic Documents

- Student Name Verification
- Result Verification
- Grade Verification
- Grand Total Verification

### Zero-Knowledge Proof Generation

Generates:

- proof.json
- public.json
- verification_key.json

### Independent Verification

Verifiers can independently verify proofs without accessing original documents.

### Multi-Attribute Verification

Supports verification of multiple claims using a single proof.

---

## System Workflow

### Prover Workflow

```text
Upload Document
        ↓
OCR Extraction
        ↓
Attribute Extraction
        ↓
Select Claims
        ↓
Generate Circuit Inputs
        ↓
Witness Generation
        ↓
Groth16 Proof Generation
        ↓
Download Proof Files
```

### Verifier Workflow

```text
Upload proof.json
Upload public.json
Upload verification_key.json
          ↓
Cryptographic Verification
          ↓
VALID / INVALID PROOF
```

---

## System Architecture

```text
Document Upload
       ↓
OCR Processing
       ↓
Document Type Detection
       ↓
Attribute Extraction
       ↓
Claim Selection
       ↓
Input Generation
       ↓
Circom Circuit
       ↓
Witness Generation
       ↓
Groth16 Proof Generation
       ↓
Proof Verification
```

---

## Technology Stack

### Frontend

- React
- TypeScript
- Vite
- Tailwind CSS
- Framer Motion

### Backend

- Node.js
- Express.js
- Multer

### Zero-Knowledge Proofs

- Circom
- SnarkJS
- Groth16
- Poseidon Hash

### OCR

- Tesseract OCR
- PDF Parsing

### Development Environment

- Ubuntu (WSL)
- Node.js
- Git

---

## Project Structure

```text
ZKP-DOCVerify
│
├── api-server-new
│   ├── routes
│   ├── middleware
│   ├── uploads
│   └── server.js
│
├── zkp-verify
│   └── Frontend Application
│
└── zk-document-verification
    ├── circuits
    ├── config
    ├── extractors
    ├── processors
    ├── documents
    ├── inputs
    ├── proofs
    └── main.js
```

---

## Installation

### Clone Repository

```bash
git clone https://github.com/gaddamaditya/privacy-preserving-document-verification.git

cd privacy-preserving-document-verification
```

---

## Backend Setup

```bash
cd api-server-new

npm install

node server.js
```

Backend runs at:

```text
http://localhost:3001
```

---

## Frontend Setup

```bash
cd zkp-verify/zkp-verify

npm install

npm run dev
```

Frontend runs at:

```text
http://localhost:5173
```

---

## ZKP Engine Setup

```bash
cd zk-document-verification

npm install
```

### Verify Installation

```bash
circom --version

snarkjs --version
```

---

## Usage

### Generate Proof

1. Open Generate Proof page
2. Upload a supported document
3. Review OCR results
4. Select verification claims
5. Click Generate Proof
6. Download:

```text
proof.json
public.json
verification_key.json
```

---

### Verify Proof

1. Open Verify Proof page
2. Upload:

```text
proof.json
public.json
verification_key.json
```

3. Click Verify Proof
4. View verification result

Example:

```text
✓ VALID PROOF

This proof is cryptographically valid.
```

or

```text
✗ INVALID PROOF

This proof failed cryptographic verification.
```

---

## Security and Privacy

The system is designed around the principle of **Selective Disclosure**.

### Private Information (Private Witness Data)

Never shared with the verifier:

- Original document
- Raw OCR text
- Private attributes and witness inputs used in circuit computation

### Shared Information (Public Signals & Proof)

Shared with the verifier:

- Zero-Knowledge Proof (`proof.json`)
- Public Signals (`public.json`)
- Verification Key (`verification_key.json`)

This allows verification of specific claims without revealing sensitive underlying document contents.

> **Note on Verification Scope:** Cryptographic verification confirms that the zero-knowledge proof is valid with respect to the compiled circuit constraints and public signals. Proof validity alone verifies the correctness of the computational assertion over the provided witness data, but does not independently establish the physical authenticity or provenance of the source document itself without an external trust anchor (such as a trusted issuer's digital signature).

---

## Research Contribution

This collaborative research project demonstrates how Zero-Knowledge Proofs can be applied to document verification systems to improve privacy and reduce unnecessary data exposure.

The implementation integrates:

- OCR
- Attribute Extraction
- Circom Circuits
- Groth16 Proving
- Cryptographic Verification

into a complete end-to-end verification workflow.

---

## Future Scope

- Additional document types
- PAN card support
- Passport verification
- Degree certificate verification
- Blockchain integration
- Smart contract verification
- Decentralized proof storage
- Mobile application support

---

## Research Authors

This project is a collaborative Summer Research Internship research project conducted by:

### Adithya Gaddam
- **Role:** Project Repository Owner
- **Department:** Department of Computer Science and Engineering
- **Institution:** SRM University-AP
- **Location:** Amaravati, Andhra Pradesh 522240, India
- **Email:** [adithya_gaddam@srmap.edu.in](mailto:adithya_gaddam@srmap.edu.in)
- **GitHub:** [https://github.com/gaddamaditya](https://github.com/gaddamaditya)

### Junaid Alam
- **Department:** Department of Computer Science and Engineering
- **Institution:** SRM University-AP
- **Location:** Amaravati, Andhra Pradesh 522240, India
- **Email:** [junaidalam.r@srmap.edu.in](mailto:junaidalam.r@srmap.edu.in)

### Yelleti Vivek
- **Department:** Area of Information Systems and Business Analytics
- **Institution:** Indian Institute of Management Ranchi
- **Location:** Ranchi, Jharkhand 835303, India
- **Email:** [yelleti.vivek@iimranchi.ac.in](mailto:yelleti.vivek@iimranchi.ac.in)

---

## Contact

- **Primary Contact:** [adithya_gaddam@srmap.edu.in](mailto:adithya_gaddam@srmap.edu.in) / [gaddamaditya8@gmail.com](mailto:gaddamaditya8@gmail.com)
- **GitHub Profile:** [https://github.com/gaddamaditya](https://github.com/gaddamaditya)
- **Repository:** [https://github.com/gaddamaditya/privacy-preserving-document-verification.git](https://github.com/gaddamaditya/privacy-preserving-document-verification.git)

---

## License

This project is developed for academic and research purposes.
